
import * as React from "react";
import { render } from "react-dom";
import { custom_greeting } from "../../declarations/custom_greeting";

const MyHello = () => {
  const [name, setName] = React.useState('');
  const [message, setMessage] = React.useState('');

  async function doGreet() {
    const greeting = await custom_greeting.greet(name);
    setMessage(greeting);
  }

  return (
    <div style={{ "fontFamily": "sans-serif" }}>
      <div style={{ "fontSize": "30px" }}>
        <p>Greetings, from DFINITY!</p>
        <p>
          {" "}
          Type your message in the Name input field, then click{" "}
          <b> Get Greeting</b> to display the result.
        </p>
      </div>
      <div style={{ margin: "30px" }}>
        <input
          id="name"
          placeholder="Type text here"
          value={name}
          onChange={(ev) => setName(ev.target.value)}
        ></input>
        <button onClick={doGreet}>Get Greeting!</button>
      </div>
      <div>
        Greeting is: "
        <span style={{ color: "green" }}>{message}</span>"
      </div>
    </div>
  );
};

render(<MyHello />, document.getElementById("app"));
