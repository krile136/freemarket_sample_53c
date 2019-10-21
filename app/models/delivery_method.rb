class DeliveryMethod < ActiveHash::Base
  self.data = [
    {id: 1, name: '未定', postage_burden_id: 1}, {id: 2, name: 'らくらくメルカリ便', postage_burden_id: 1}, {id: 3, name: 'ゆうメール', postage_burden_id: 1}, {id: 4, name: 'レターパック', postage_burden_id: 1}, {id: 5, name: '普通郵便(定形、定形外)', postage_burden_id: 1}, {id: 6, name: 'クロネコヤマト', postage_burden_id: 1},
    {id: 7, name: 'ゆうパック', postage_burden_id: 1}, {id: 8, name: 'クリックポスト', postage_burden_id: 1}, {id: 9, name: 'ゆうパケット', postage_burden_id: 1},
    {id: 10, name: '未定', postage_burden_id: 2}, {id: 11, name: 'クロネコヤマト', postage_burden_id: 2}, {id: 12, name: 'ゆうパック', postage_burden_id: 2}, {id: 13, name: 'ゆうメール', postage_burden_id: 2}
  ]
end