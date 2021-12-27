function add_text_area() {
    let result = document.querySelector(".text_div");
    let div = document.createElement('div');
    div.setAttribute('class', 'field');
    result.appendChild(div);
    let txt_area = document.createElement('textarea');
    txt_area.setAttribute('name', 'text[]');
    div.appendChild(txt_area);
    let br = document.createElement('br');
    div.appendChild(br);
}
function add_image() {
    let result = document.querySelector(".text_div");
    let div = document.createElement('div');
    div.setAttribute('class', 'field');
    result.appendChild(div);
    let p = document.createElement('p');
    p.append('Пожалуйста, введите URL картинки, которую вы хотите вставить:');
    div.appendChild(p);
    let img_field = document.createElement('input');
    img_field.setAttribute('type', 'url');
    img_field.setAttribute('name', 'text[]');
    div.appendChild(img_field);
    let br = document.createElement('br');
    div.appendChild(br);
}
window.addEventListener("load", () => {
    let add_txt_btn = document.querySelector("#add_txt_btn");
    add_txt_btn.addEventListener("ajax:success", (event) => {
        add_text_area();
    });
    let add_img_btn = document.querySelector("#add_img_btn");
    add_img_btn.addEventListener("ajax:success", (event) => {
        add_image();
    });
});