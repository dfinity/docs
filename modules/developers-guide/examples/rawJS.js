import hello_world from 'ic:canisters/hello_world';

hello_world.greet(window.prompt("Enter your name:")).then(greeting => {
  window.alert(greeting);
});
