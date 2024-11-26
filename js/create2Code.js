

const contractAddress = "0xA13645EdEaC241c226F2170bbb9F43Ba7A363193"; 
web3.eth.getCode(contractAddress, (error, bytecode) => {
  if (error) {
    console.error('Error:', error);
  } else {
    console.log('Bytecode:', bytecode);
  }
});