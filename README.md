Media Pipeline Demo
===================

This is a sample project to demonstrate the use of BuckleScript and serverless
to build a Media Processing pipeline using AWS API Gateway and Lambda. It goes
along with the [article posted on Medium](https://medium.com/@romain.beauxis/scalable-and-serverless-media-processing-using-bucklescript-ocaml-and-aws-lambda-api-gateway-4efe39331f33).

Installing
----------

First, you need to install the `opam` package manager: [instructions here](https://opam.ocaml.org/doc/Install.html).

Then, you need to install `Node.js` and `npm`: [instructions here](https://nodejs.org/en/download/).

Finally, from this repository's folder:

```
% opam switch 4.02.3+buckle-master
% eval `opam config env`
% npm install
% npm run build
```

That should give you the Javascript compiled code in the `lib/` directory. You can now test
the code by calling `serverless offline`.

If you want to deploy to test, you should edit the `serverless.yml` file execute: `serverless deploy`.
