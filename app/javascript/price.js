const priceInput = document.getElementById('item-price');
const addTaxPrice = document.getElementById('add-tax-price');
const profit = document.getElementById('profit');

priceInput.addEventListener('input', () => {
  const price = priceInput.value;
  if (price >= 300 && price <= 9999999) {
    const fee = Math.floor(price * 0.1);
    const profitValue = Math.floor(price - fee);
    addTaxPrice.innerHTML = fee.toLocaleString();
    profit.innerHTML = profitValue.toLocaleString();
  } else {
    addTaxPrice.innerHTML = '-';
    profit.innerHTML = '-';
  }
});