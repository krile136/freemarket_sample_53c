class DeliveryMethod < ActiveHash::Base
  self.data = [
    {id: 1, name: '未定', payside_id: 1}, {id: 2, name: 'らくらくメルカリ便', payside_id: 1}, {id: 3, name: 'ゆうメール', payside_id: 1}, {id: 4, name: 'レターパック', payside_id: 1}, {id: 5, name: '普通郵便(定形、定形外)', payside_id: 1}, {id: 6, name: 'クロネコヤマト', payside_id: 1},
    {id: 7, name: 'ゆうパック', payside_id:1}, {id: 8, name: 'クリックポスト', payside_id: 1}, {id: 9, name: 'ゆうパケット', payside_id: 1},
    {id: 10, name: '未定', payside_id: 2}, {id: 11, name: 'クロネコヤマト', payside_id: 2}, {id: 12, name: 'ゆうパック', payside_id: 2}, {id: 13, name: 'ゆうメール', payside_id: 2}
  ]
end