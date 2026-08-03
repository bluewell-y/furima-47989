const initPayjp = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const publicKey = document.querySelector("[data-public-key]").dataset.publicKey;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        form.submit();
      } else {
        const tokenObj = document.createElement("input");
        tokenObj.setAttribute("type", "hidden");
        tokenObj.setAttribute("name", "order_address[token]");
        tokenObj.setAttribute("value", response.id);
        form.appendChild(tokenObj);

        const numberForm = document.getElementById("number-form");
        if (numberForm) numberForm.removeAttribute("name");

        form.submit();
      }
    });
  });
};

window.addEventListener("turbo:load", initPayjp);
window.addEventListener("turbo:render", initPayjp);