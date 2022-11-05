"use strict";
const { ok } = require("assert");
const Web3 = require("web3");
const { compileExtractCompare } = require("smart-contract-verifier");

module.exports.lambda_handler = async (event) => {
  console.log({ event });
  const body = JSON.parse(event.body);
  console.log({ body });
  const {
    file,
    fileName,
    contractName,
    contractFilename,
    contractAddress,
    solcVersion,
  } = body;
  const sources = { [fileName]: file };
  ok(process.env.RPC_PROVIDER);
  const web3 = new Web3(
    new Web3.providers.HttpProvider(process.env.RPC_PROVIDER)
  );
  const matching = await compileExtractCompare(
    web3,
    sources,
    solcVersion,
    contractName,
    contractFilename,
    contractAddress
  );
  console.log({ matching });
  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        matching,
      },
      null,
      2
    ),
  };
};
