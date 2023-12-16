//
//  IAP.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/12.
//

import SwiftUI

struct IAP: View {
    
    //1、 创建Store实体
    @StateObject var store = Store()
    
    var body: some View {
        //2、 依次读取已经存在的所有内购选项
        ForEach(store.allProducts, id: \.self) { product in
            if !product.isLocked {  //若购买，则显示该内容
                Text("已解锁Pro版本")
            } else {  //若没购买，显示购买按钮（价格），恢复购买按钮
                if let price = product.price, product.isLocked {
                    HStack {
                        Button {
                            if let product = store.product(for: product.id) {
                                store.purchaseProduct(product)  //Store中的购买函数
                            }
                        } label: {
                            Text(price)
                                .fontWeight(.semibold)
                                .padding(8)
                                .padding(.horizontal, 8)
                                .background(Color.orange.opacity(0.07).cornerRadius(100))
                        }
                        .buttonStyle(.plain) //默认列表中一行代表一个按钮，让一行可以执行两个按钮

                        Spacer()
                        
                        Button {
                            store.restorePurchases()  //Store中的恢复购买函数
                        } label: {
                            Text("恢复购买")
                        }
                        .buttonStyle(.plain)
                    }
                    .foregroundColor(.orange)
                    
                }
            }
        }
        //3、 该视图出现时，刷新内购状态
        .onAppear {
            store.loadStoredPurchases()
        }
    }
}

struct IAP_Previews: PreviewProvider {
    static var previews: some View {
        IAP()
    }
}
