# Write code for the Internet Computer

You can get started right away by downloading the Internet Computer Software Development Kit (SDK) and cloning an existing sample project or by exploring the documentation. Check out the links below to begin building smart contract canisters to run on the Internet Computer:

- [*Get the SDK*](https://sdk.dfinity.org/docs/download.html) Download the SDK for the Internet Computer.
- [*Quick Start*](https://sdk.dfinity.org/docs/quickstart/quickstart-intro.html) Deploy your first app on the Internet Computer.
- [*Examples Repository*](https://github.com/dfinity/examples) Explore on your own in the examples repository.
- [*Language Guide*](https://sdk.dfinity.org/docs/language-guide/motoko.html) Explore the Motoko programming language.
- [*Videos*](https://sdk.dfinity.org/docs/videos-tutorials.html) Watch the _Building Applications for the Internet Computer: Fundamentals_ video series.

# Contributing to the documentation

The [Internet Computer blockchain](https://dfinity.org/developers) is removing the limitations from smart contract software with a network that scales its capacity with demand and serves interactive web content directly to end users. 
If you are interested in learning more about the project, you can connect with other developers in the community through the [Developer Forum](https://forum.dfinity.org/) and follow us on social media for information about upcoming events and new developments.

If you would like to contribute to the documentation, see our [CONTRIBUTING](.github/CONTRIBUTING.md) and [CODE OF CONDUCT](.github/CODE_OF_CONDUCT.md) to get started.

## Updating the Site Navigation

To update the left-side site navigation, make changes to [nav.adoc](modules/ROOT/nav.adoc).

## Testing your changes locally

To test your changes locally, clone the [dfinity-docs-playbook] https://github.com/dfinity/dfinity-docs-playbook and follow the installation instructions. Push the changes you want to preview up to a branch on GitHub. You will need to modify the 
antora-playbook.yml to point to your branch, which will look something like

```
content:
  sources:
    # Remote repositories and branches
    - url: git@github.com:dfinity/docs.git
      branches: "your-branch-name"
```

> Note: the URL may be different if you are working from a fork

Then, run `npm run build` to compile the documentation.

You will then need to open the static directory in your browser with a simple static file server to preview your changes. 

> Note - the root page of the site automatically redirects to https://smartcontracts.org, so you will need to skip past the index to another page. For example, http://127.0.0.1:5500/build/site/docs/quickstart/local-quickstart.html.
