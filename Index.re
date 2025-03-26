type todo_item = {
  id: int,
  contents: string,
  done_: bool,
};

let setItemDone = (items, i) => {
  let itemsCopy = Array.copy(items);
  let oldItem = itemsCopy[i];
  let newItem = {
    id: oldItem.id,
    contents: oldItem.contents,
    done_: !oldItem.done_,
  };
  itemsCopy[i] = newItem;
  itemsCopy;
};

module TodoList = {
  [@react.component]
  let make = (~items, ~setItems, ()) => {
    let renderedItems =
      Array.mapi(
        (i, item) => {
          let style =
            item.done_
              ? ReactDOM.Style.make(~textDecoration="line-through", ())
              : ReactDOM.Style.make();

          <li key={string_of_int(item.id)} style>
            {React.string(item.contents)}
            <input
              type_="checkbox"
              checked={item.done_}
              onChange={_ => setItems(items => setItemDone(items, i))}
            />
          </li>;
        },
        items,
      )
      |> React.array;
    <>
      <ul> renderedItems </ul>
      <button
        onClick={_ => setItems(Js.Array.filter(~f=item => !item.done_))}>
        {React.string("Clear")}
      </button>
    </>;
  };
};

module App = {
  [@react.component]
  let make = () => {
    let (input, setInput) = React.useState(() => "");
    let (items, setItems) = React.useState(() => [||]);

    <div>
      <h1> {React.string("Todo App")} </h1>
      <input
        type_="string"
        value=input
        onChange={event => setInput(React.Event.Form.target(event)##value)}
      />
      <button
        disabled={input == ""}
        onClick={_event => {
          setItems(items => {
            let id =
              Array.length(items) == 0
                ? 1 : 1 + items[Array.length(items) - 1].id;

            Array.append(
              items,
              [|
                {
                  id,
                  contents: input,
                  done_: false,
                },
              |],
            );
          });
          setInput(_ => "");
        }}>
        {React.string("Add")}
      </button>
      <TodoList items setItems />
    </div>;
  };
};

let () = {
  let node = ReactDOM.querySelector("#root");
  switch (node) {
  | None =>
    Js.Console.error("Failed to start React: couldn't find the #root element")
  | Some(root) =>
    let root = ReactDOM.Client.createRoot(root);
    ReactDOM.Client.render(root, <App />);
  };
};
