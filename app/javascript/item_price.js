// 画面が読み込まれたら実行されるようにする
const price = () => {
  // 金額を入力するフォームの要素を取得
  const priceInput = document.getElementById("item-price");
  
  // 要素が存在しないページ（トップページなど）でのエラーを防ぐための条件分岐
  if (!priceInput) return;

  // 金額が入力されるたびに動くイベント（input）を設定
  priceInput.addEventListener("input", () => {
    // 計算処理を行う
    const inputValue = priceInput.value;

    // 表示させる対象のHTML要素（販売手数料と販売利益）を取得
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    // 入力した金額に10%をかけ算し、Math.floorで小数点以下を切り捨てる
    const taxPrice = Math.floor(inputValue * 0.1);
    // 入力した金額から販売手数料を引いて、販売利益を算出する
    const profitPrice = Math.floor(inputValue - taxPrice);

    // 計算結果をそれぞれのHTML要素にテキストとして表示させる
    addTaxDom.innerHTML = taxPrice;
    profitDom.innerHTML = profitPrice;
  });
};

// 通常の画面遷移やリロード時に動かす
window.addEventListener('turbo:load', price);
// バリデーションエラーなどで render メソッドが呼ばれた際にも動かす
window.addEventListener('turbo:render', price);