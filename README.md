# Elm SPA Playground
Playing around with Elm SPAs and structuring them for larger scale applications

### Tooling
To get started, make sure you have the [Elm toolchain installed](https://guide.elm-lang.org/install.html). Beyond that, we also need a few more command line tools that we use.

```bash
$ npm install -g elm-format elm-test elm-verify-examples elm-analyse
```

### Unit Tests
We use [elm-test](https://github.com/elm-community/elm-test) to run our unit tests, in the `tests/` folder.

Run `elm-test` to run the tests-

### Verified Examples in Documentation
We use [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples) to ensure that code in documentation is kept up-to-date. This is similar to tools liek doc-tests in other languages.

A brief example, that'll be validated.

```elm
1+1 --> 2
```

Running `elm-verify-examples --run-tests` will both generate and validate these docs. Make sure you have added the fils to check in `tests/elm-verify-examples.json`.

### CI
We use Github actions to build the project, run tests, and run doc tests in the CI pipeline. Check out the workflows in `.github/workflows/` to see the specific workflows that are set up.

### Resources

- [Intro to Elm](https://guide.elm-lang.org)
- [Scaling Views with Master View Types](https://discourse.elm-lang.org/t/scaling-views-with-master-view-types/4014)
- [Real World Elm SPA Example](https://github.com/rtfeldman/elm-spa-example)

**Testing:**

- [elm-program-test](https://discourse.elm-lang.org/t/elm-program-test-3-0-0-new-docs-support-for-http-and-ports/4235)
- [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples)
- [elm-test](https://github.com/elm-community/elm-test)

**Some base library functions that one should be familiar with:**

- [Url Parser](https://package.elm-lang.org/packages/elm/url/latest/Url-Parser)
- [Browser (specifically application)](https://package.elm-lang.org/packages/elm/browser/latest/Browser#application)
- [Browser Navigation](https://package.elm-lang.org/packages/elm/browser/1.0.0/Browser-Navigation)
