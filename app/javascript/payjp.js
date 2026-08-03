const initPayjp = () => {
  console.log("payjp.js is running");

  const form = document.getElementById("charge-form");
  if (!form) return;

  console.log("form found:", form);

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
    console.log("submit event fired");

    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      console.log(response);

      if (response.error) {
        console.log(response.error.message);
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