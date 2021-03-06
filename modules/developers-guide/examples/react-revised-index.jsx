// Modify the front-end in the React JavaScript
class MyHello extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      message: '',
    };
  }

  async doGreet() {
    const greeting = await custom_greeting.greet(this.state.name);
    this.setState({ ...this.state, message: greeting });
  }

  onNameChange(ev) {
    this.setState({ ...this.state, name: ev.target.value });
  }

  render() {
    return (
      <div style={{ "font-family": "sans-serif" }}>
      <div style={{ "font-size": "30px" }}>
          <p>Greetings, from DFINITY!</p>
          <p> Type your message in the Name input field, then click <b> Get Greeting</b> to display the result.</p>

        <div style={{ "margin": "30px" }}>
          <input id="name" placeholder="Type text here" value={this.state.name} onChange={ev => this.onNameChange(ev)}></input>
          <button onClick={() => this.doGreet()}>Get Greeting!</button>
        </div>
        <div>Greeting is: "<span style={{ "color": "green" }}>{this.state.message}</span>"</div>
      </div>
    </div>
    );
  }
}

render(<MyHello />, document.getElementById('app'));
