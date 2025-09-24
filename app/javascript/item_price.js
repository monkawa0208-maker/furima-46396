const price = () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    console.log(inputValue);
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");
    const tax_rate = 0.1;
    addTaxDom.innerHTML = Math.floor(inputValue * tax_rate);
    profitDom.innerHTML = Math.floor(inputValue * (1 - tax_rate));
  })
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
