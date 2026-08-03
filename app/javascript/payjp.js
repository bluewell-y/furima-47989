const initPayjp = () => {
  console.log("payjp.js is running");

  // 購入フォームが存在しないページ（トップページなど）でのエラーを防ぐ
  const form = document.getElementById("charge-form");
  if (!form) return;

  console.log("form found:", form);

  // 公開鍵を使ってPAY.JPのインスタンスを作成（動作確認用に直接記述、後ほど環境変数化する）
  const publicKey = document.querySelector("[data-public-key]").dataset.publicKey;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  // カード情報の入力欄（カード番号・有効期限・セキュリティコード）を生成
  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  // それぞれ対応するdivタグに埋め込む
  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  // 購入ボタンが押されたときの処理
  form.addEventListener("submit", (e) => {
    console.log("submit event fired");

    // 一旦、通常のフォーム送信をキャンセルする
    e.preventDefault();

    // カード情報をもとにトークンを生成する
    payjp.createToken(numberElement).then((response) => {
      console.log(response);

      if (response.error) {
        // トークン生成に失敗した場合
        console.log(response.error.message);
      } else {
        // トークン生成に成功した場合、tokenをhidden項目としてフォームに追加する
        const tokenObj = document.createElement("input");
        tokenObj.setAttribute("type", "hidden");
        tokenObj.setAttribute("name", "order_address[token]");
        tokenObj.setAttribute("value", response.id);
        form.appendChild(tokenObj);

        // カード情報の入力欄（name属性がないため問題ないが念のため）を送信対象から除外
        const numberForm = document.getElementById("number-form");
        if (numberForm) numberForm.removeAttribute("name");

        // トークンを追加した状態で、あらためてフォームを送信する
        form.submit();
      }
    });
  });
};

// 通常の画面遷移やリロード時に動かす
window.addEventListener("turbo:load", initPayjp);
// バリデーションエラーなどで render メソッドが呼ばれた際にも動かす
window.addEventListener("turbo:render", initPayjp);