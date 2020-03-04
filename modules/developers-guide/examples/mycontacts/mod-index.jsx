import contact from 'ic:canisters/contacts';
import * as React from 'react';
import { render } from 'react-dom';

import './mycontacts.css'; // Import custom styles

class Contact extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
    };
  }

  async doInsert() {
    let name = document.getElementById("newEntryName").value;
    let add1 = document.getElementById("newEntryAddress1").value;
    let add2 = document.getElementById("newEntryAddress2").value;
    let email = document.getElementById("newEntryEmail").value;
    let phone = document.getElementById("newEntryPhone").value;

    contact.insert(name, add1, add2, email, parseInt(phone, 10));
  }

  async lookup() {
    let name = document.getElementById("lookupName").value;
    contact.lookup(name).then(opt_entry => {
      let [entry] = opt_entry;

      if (entry.length == 0) {
        entry = { name: "", description: "", phone: ""};
      } else {
        entry = entry[0]
      }      

      document.getElementById("newEntryName").value = entry.name;
      document.getElementById("newEntryAddress1").value = entry.address1;
      document.getElementById("newEntryAddress2").value = entry.address2;
      document.getElementById("newEntryEmail").value = entry.email;
      document.getElementById("newEntryPhone").value = entry.phone.toString();
    });
  }

  render() {
    return (
      <div class="new-entry">
        <h1>My Contacts</h1>
        <div>
          Add or update contact information:
	      <form id="contact">
          <table>
            <tr><td>Name:</td><td><input id="newEntryName"></input></td></tr>
            <tr><td>Address 1 (street):</td><td><input id="newEntryAddress1"></input></td></tr>
            <tr><td>Address 2 (city and state):</td><td><input id="newEntryAddress2"></input></td></tr>
            <tr><td>Email:</td><td><input id="newEntryEmail"></input></td></tr>
            <tr><td>Phone:</td><td><input id="newEntryPhone" type="number"></input></td></tr>
          </table>
        </form>
        </div>
        <div>
          <button onClick={() => this.doInsert()}>Add Contact</button>
        </div>
        <div>
          Lookup name: <input id="lookupName" style={{ "line-height": "20px" }}></input>
          <button onClick={() => this.lookup()}>Lookup</button>
        </div>
      </div>
    );
  }
}

document.title = "DFINITY CONTACT EXAMPLE";

render(<Contact />, document.getElementById('app'));
