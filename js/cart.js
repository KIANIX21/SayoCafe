const addToCartButton = document.querySelector('.btn');
addToCartButton.addEventListener('click', () => {
    // Ambil data produk yang ingin ditambahkan ke keranjang
    const productName = document.getElementById('namaMakanan').textContent;
    const productPriceElement = document.querySelector('h4');
    const productPrice = parseFloat(productPriceElement.textContent.replace('Rp', '').replace('.', ''));
    const categname = document.getElementById('categName').textContent;

    console.log('productName:', productName);
    console.log('productPrice:', productPrice);
    console.log('categname:', categname);

    // Ambil kuantitas
    const quantityInput = document.getElementById('quantity');
    const quantity = parseInt(quantityInput.value);

    // Hitung total harga dengan mengalikan harga dan kuantitas
    let totalPrice = productPrice;
    if (quantity > 1) {
        totalPrice = productPrice * quantity;
    }

    // Tampilkan hasil perkalian harga dan kuantitas di dalam elemen h4
    productPriceElement.textContent = `Rp${totalPrice.toLocaleString()}`;

    // Buat objek produk baru
    const product = { name: productName, price: totalPrice, category: categname };

    // Cek apakah keranjang belanja sudah ada di session storage
    let cart = sessionStorage.getItem('cart');
    if (cart === null) {
        // Jika belum ada, buat keranjang baru
        cart = [];
    } else {
        // Jika sudah ada, parsing isi keranjang menjadi array
        cart = JSON.parse(cart);
    }

    // Cek apakah produk sudah ada di dalam keranjang
    const existingProductIndex = cart.findIndex(item => item.name === productName);
    console.log('existingProductIndex:', existingProductIndex);
    console.log('cart:', cart);
    if (existingProductIndex > -1) {
        // Jika produk sudah ada, tambahkan kuantitasnya
        cart[existingProductIndex].quantity += quantity;
    } else {
        // Jika belum ada, tambahkan produk ke dalam keranjang
        cart.push({ ...product, quantity });
    }

    // Simpan kembali isi keranjang belanja ke session storage
    sessionStorage.setItem('cart', JSON.stringify(cart));
    renderCartItems();
});
