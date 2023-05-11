const addToCartButton = document.querySelector('.btn');
addToCartButton.addEventListener('click', () => {
    // Ambil data produk yang ingin ditambahkan ke keranjang
    const productName = document.getElementById('namaMakanan').textContent;
    const productPrice = document.querySelector('h4').textContent;
    const categname = document.getElementById('categName').textContent;

    // Buat objek produk baru
    const product = { name: productName, price: productPrice, category: categname };

    // Cek apakah keranjang belanja sudah ada di session storage
    let cart = sessionStorage.getItem('cart');
    if (cart === null) {
        // Jika belum ada, buat keranjang baru
        cart = [];
    } else {
        // Jika sudah ada, parsing isi keranjang menjadi array
        cart = JSON.parse(cart);
    }

    // Tambahkan produk ke dalam keranjang
    cart.push(product);

    // Simpan kembali isi keranjang belanja ke session storage
    sessionStorage.setItem('cart', JSON.stringify(cart));
    renderCartItems();
});