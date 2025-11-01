let productsData = {};

function renderCategories(data) {

  productsData = data;
  const container = document.querySelector(".categories");
  container.innerHTML = '';

  Object.keys(data).forEach(category => {
    const a = document.createElement('a');
    a.className = 'category-item';
    a.setAttribute('data-category', category);
    a.href = "#";
    a.innerText = category;
    container.appendChild(a);
  });

  bindCategoryClick();
  renderProducts(Object.keys(productsData)[0]);
}

function bindCategoryClick() {
  document.querySelectorAll(".category-item").forEach(item => {
    item.addEventListener("click", () => {
      const selectedCategory = item.getAttribute("data-category");
      renderProducts(selectedCategory);
    });
  });
}

function renderProducts(category) {
  const container = document.getElementById("product-list");
  container.innerHTML = "";
  const row = document.createElement("div");
  row.className = "product-row";

  (productsData[category] || []).forEach(product => {
    const card = document.createElement("div");
    card.className = "product-card";
    card.innerHTML = `
      <img src="${product.image}" alt="${product.name}" class="product-image">
      <a class="product-name">${product.name}</a>
      <a class="product-price">$${product.price.toFixed(2)}</a>
      <a class="product-stock">${product.stock}</a>
      <button 
        class="add-to-cart-btn"
        data-name="${product.name}"
        data-price="${product.price}"
        data-image="${product.image}"
        data-item_name="${product.item_name}"
        data-item_stock="${product.stock}"
        ${product.stock === 0 ? 'disabled' : ''}>
        Add to Cart
      </button>

    `;
    row.appendChild(card);
  });

  container.appendChild(row);
  bindAddToCart();
}

function bindAddToCart() {
  document.querySelectorAll('.add-to-cart-btn').forEach(button => {
    button.addEventListener('click', () => {
      const name = button.getAttribute('data-name');
      const itemName = button.getAttribute('data-item_name');
      const existingItem = document.querySelector(`.added-products[data-name="${name}"]`);
      if (existingItem) {
        
        return;
      }

      const price = parseFloat(button.getAttribute('data-price'));
      const image = button.getAttribute('data-image');
      const itemStock = parseInt(button.getAttribute('data-item_stock'));
      const cartItem = document.createElement('div');
      cartItem.className = 'added-products';
      cartItem.setAttribute('data-name', name);
      cartItem.setAttribute('data-item_name', itemName);
      cartItem.innerHTML = `
        <img src="${image}" class="added-products-image">
        <div class="product-details">
          <a class="added-products-name">${name}</a>
          <a class="added-products-price">$${price.toFixed(2)}</a>
        </div>
        <input type="number" class="added-products-textarea" value="1" min="1" max=${itemStock} />
        <a class="added-products-price-display">$${price.toFixed(2)}</a>
        <button type="button" class="delete-button">
          <img src="assets/delete.png" alt="Delete" class="delete-icon">
        </button>
      `;
      const inputField = cartItem.querySelector('.added-products-textarea');
      inputField.addEventListener('input', () => {
        const max = parseInt(inputField.max);
        const min = parseInt(inputField.min);
        let value = parseInt(inputField.value);
      
        if (value > max) inputField.value = max;
        if (value < min || isNaN(value)) inputField.value = min;
      });

      document.getElementById('cart-products').appendChild(cartItem);

      cartItem.querySelector('.delete-button').addEventListener('click', () => {
        cartItem.remove();
        updateTotalPrice();
      });

      updateProductTotal(cartItem);
      updateTotalPrice();
    });
  });
}

function clearCartItems() {
  const cartContainer = document.getElementById('cart-products');
  cartContainer.innerHTML = '';
  updateTotalPrice(); 
}


function updateProductTotal(product) {
  const priceText = product.querySelector('.added-products-price').textContent.replace('$', '');
  const input = product.querySelector('.added-products-textarea');
  const display = product.querySelector('.added-products-price-display');

  input.addEventListener('input', () => {
    const qty = parseFloat(input.value) || 0;
    const unitPrice = parseFloat(priceText);
    const total = (qty * unitPrice).toFixed(2);
    display.textContent = `$${total}`;
    updateTotalPrice();
  });
}

function updateTotalPrice() {
  let total = 0;
  document.querySelectorAll('.added-products-price-display').forEach(el => {
    const value = parseFloat(el.textContent.replace('$', ''));
    if (!isNaN(value)) total += value;
  });
  const totalPriceEl = document.querySelector('.total-price');
  if (totalPriceEl) totalPriceEl.textContent = `Total: $${total.toFixed(2)}`;
}

document.addEventListener('DOMContentLoaded', function () {
    updateTotalPrice();
    document.querySelector('.pay-button-cash').addEventListener('click', () => {
        const cartItems = document.querySelectorAll('.added-products');
        if (cartItems.length === 0) return;
        const itemsToSend = [];
        cartItems.forEach(item => {
            const name = item.getAttribute('data-item_name');
            const quantity = parseInt(item.querySelector('.added-products-textarea')?.value) || 0;
            const totalPrice = parseFloat(item.querySelector('.added-products-price-display')?.textContent.replace('$', '')) || 0;
    
            itemsToSend.push({
                item: name,
                quantity: quantity,
                total: totalPrice.toFixed(2)
            });
        });
    
        fetch(`https://${GetParentResourceName()}/purchaseItems`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({ items: itemsToSend, paymentMethod: 'cash'  })
        }); 
        clearCartItems()
    });

    document.querySelector('.pay-button-bank').addEventListener('click', () => {
        const cartItems = document.querySelectorAll('.added-products');
        if (cartItems.length === 0) return;
        const itemsToSend = [];
        cartItems.forEach(item => {
            const name = item.getAttribute('data-item_name');
            const quantity = parseInt(item.querySelector('.added-products-textarea')?.value) || 0;
            const totalPrice = parseFloat(item.querySelector('.added-products-price-display')?.textContent.replace('$', '')) || 0;
    
            itemsToSend.push({
                item: name,
                quantity: quantity,
                total: totalPrice.toFixed(2)
            });
        });
        
        fetch(`https://${GetParentResourceName()}/purchaseItems`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({ items: itemsToSend, paymentMethod: 'bank' })
        }); 
        clearCartItems()
    });
});

window.addEventListener('message', function(event) {
  if (event.data.action === "showUI") {
    document.getElementById("ui").style.display = "block";
    requestAnimationFrame(() => {
      renderCategories(event.data.products);
    });
  }
});

document.addEventListener("keydown", function(event) {
  if (event.key === "Escape") {
      clearCartItems()
      document.getElementById("ui").style.display = "none";
      axios.post(`https://${GetParentResourceName()}/hideFrame`, {})
      .then(function (response) { 
      })
      .catch(function (error) {
      });
  }
});

window.addEventListener('message', function(event) {
  if (event.data.action === "hideUI") {
    clearCartItems()
      document.getElementById("ui").style.display = "none";
      axios.post(`https://${GetParentResourceName()}/hideFrame`, {})
      .then(function (response) { 
      })
      .catch(function (error) {
      });
  }
});

function exit(){
  clearCartItems()
  document.getElementById("ui").style.display = "none";  
  axios.post(`https://${GetParentResourceName()}/hideFrame`, {})
}
