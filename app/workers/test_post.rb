# require 'rest-client'
# require 'rexml/document'
# require 'base64'
# require 'uuid'

# # message = %Q(data=<DTC_Message><MessageHead><MessageType>XXXX</MessageType><MessageId>XXXXX</MessageId><ActionType>XXX</ActionType><MessageTime>XXXX</MessageTime><SenderId>XXXX</SenderId><ReceiverId>XXXX</ReceiverId><UserNo>XXXXX</UserNo><Password>XXXXX</Password></MessageHead><MessageBody><DTCFlow><SKU_INFO><ESHOP_ENT_CODE>XXXXXX</ESHOP_ENT_CODE><ESHOP_ENT_NAME>XXXXXX</ESHOP_ENT_NAME><SKU>XXXXX</SKU><GOODS_NAME>XXX</GOODS_NAME><GOODS_SPEC>900g</GOODS_SPEC><DECLARE_UNIT>XXX</DECLARE_UNIT><POST_TAX_NO>XXXX</POST_TAX_NO><LEGAL_UNIT>XXX</LEGAL_UNIT><CONV_LEGAL_UNIT_NUM>XXXXXX</CONV_LEGAL_UNIT_NUM><HS_CODE>XXXXXX</HS_CODE><IN_AREA_UNIT>XXX</IN_AREA_UNIT><CONV_IN_AREA_UNIT_NUM>XXX</CONV_IN_AREA_UNIT_NUM></SKU_INFO></DTCFlow></MessageBody></DTC_Message>)


# puts UUID.new.generate

# def get_order_xml(order)
#   order_template = File.open('order_template.xml')
#   order_xml = REXML::Document.new order_template
#   order_xml.get_elements("//MessageHead/MessageId")[0].text = UUID.new.generate
#   order_xml.get_elements("//MessageHead/MessageTime")[0].text = Time.now
#   order_xml.get_elements("//MessageHead/SenderId")[0].text = ENV['CUSTOM_CODE']
#   order_xml.get_elements("//MessageHead/UserNo")[0].text = ENV['CUSTOM_CODE']
#   order_xml.get_elements("//MessageHead/Password")[0].text = ENV['CQITC_PASSWORD']


#   order_xml.get_elements("//MessageBody/ORIGINAL_ORDER_NO")[0].text = order.origin_order_number
#   order_xml.get_elements("//MessageBody/ESHOP_ENT_CODE")[0].text = ENV['CUSTOM_CODE']
#   order_xml.get_elements("//MessageBody/ESHOP_ENT_NAME")[0].text = "公司名称"
#   order_xml.get_elements("//MessageBody/DESP_ARRI_COUNTRY_CODE")[0].text = "起运国"
#   order_xml.get_elements("//MessageBody/SHIP_TOOL_CODE")[0].text = "运输方式"
#   order_xml.get_elements("//MessageBody/RECEIVER_ID_NO")[0].text = order.id_number
#   order_xml.get_elements("//MessageBody/RECEIVER_NAME")[0].text = order.customer_name
#   order_xml.get_elements("//MessageBody/RECEIVER_ADDRESS")[0].text = order.shipping_address
#   order_xml.get_elements("//MessageBody/RECEIVER_TEL")[0].text = order.phone
#   order_xml.get_elements("//MessageBody/GOODS_FEE")[0].text = order.total_price
#   order_xml.get_elements("//MessageBody/TAX_FEE")[0].text = order.total_tax_fee
#   order_xml.get_elements("//MessageBody/GROSS_WEIGHT")[0].text = order.total_weight

#   order.order_products.each do |order_product|
#     order_detail = order_xml.get_elements("//MessageBody")[0].add_element("ORDER_DETAIL")
#     sku = order_detail.add_element("SKU")
#     sku.add_text order_product.product.custom_code
#     goods_spec = order_detail.add_element("GOODS_SPEC")
#     goods_spec.add_text order_product.product.name
#     currency_code = order_detail.add_element("CURRENCY_CODE")
#     currency_code.add_text "币制代码"
#     price = order_detail.add_element("PRICE")
#     price.add_text order_product.product.custom_price
#     number = order_detail.add_element("QTY")
#     number.add_text order_product.number
#     total_price = order_detail.add_element("GOODS_FEE")
#     total_price.add_text order_product.item_total_price
#     total_tax_fee = order_detail.add_element("TAX_FEE")
#     total_tax_fee = order_detail.item_total_tax_fee
#   end
#   #           <SKU>商品货号</SKU>
#   #           <GOODS_SPEC>规格型号</GOODS_SPEC>
#   #           <CURRENCY_CODE>币制代码</CURRENCY_CODE>
#   #           <PRICE>商品单价</PRICE>
#   #           <QTY>数量</QTY>
#   #           <GOODS_FEE>商品总价</GOODS_FEE>
#   #           <TAX_FEE>税款金额</TAX_FEE>
#   #         </ORDER_DETAIL>
#   #       </ORDER_HEAD>

#   puts order_xml
# end

# get_order_xml




# # create_table "order_products", force: :cascade do |t|
# #   t.integer  "order_id"
# #   t.integer  "product_id"
# #   t.decimal  "custom_price"
# #   t.integer  "number"
# #   t.datetime "created_at",   null: false
# #   t.datetime "updated_at",   null: false
# # end

# # create_table "order_statuses", force: :cascade do |t|
# #   t.string   "status"
# #   t.datetime "created_at", null: false
# #   t.datetime "updated_at", null: false
# # end

# # create_table "orders", force: :cascade do |t|
# #   t.integer  "order_status_id"
# #   t.string   "origin_order_number"
# #   t.string   "origin_payment_number"
# #   t.string   "customer_name"
# #   t.string   "phone"
# #   t.string   "id_number"
# #   t.string   "province"
# #   t.string   "city"
# #   t.string   "street"
# #   t.string   "zip_code"
# #   t.datetime "created_at",            null: false
# #   t.datetime "updated_at",            null: false
# #   t.integer  "user_id"
# #   t.string   "area"
# #   t.decimal  "shipping_fee"
# # end

# # <DTC_Message>
# #   <MessageHead>
# #     <MessageType>ORDER_INFO</MessageType>
# #     <MessageId>A8A2C5E52924A114B300842B567E1315 (唯一ID 自己发送)</MessageId>
# #     <ActionType>1</ActionType>
# #     <MessageTime>时间</MessageTime>
# #     <SenderId>海关10位编码</SenderId>
# #     <ReceiverId>CQITC</ReceiverId>
# #     <SenderAddress/>
# #     <ReceiverAddress/>
# #     <PlatFormNo/>
# #     <CustomCode/>
# #     <SeqNo/>
# #     <Note/>
# #     <UserNo>海关10位编码</UserNo>
# #     <Password>加密后的字符串</Password>
# #   </MessageHead>
# #   <MessageBody>
# #     <DTCFlow>
# #       <ORDER_HEAD>
# #         <CUSTOMS_CODE>关区代码</CUSTOMS_CODE>
# #         <BIZ_TYPE_CODE>直购，网购代码</BIZ_TYPE_CODE>
# #         <ORIGINAL_ORDER_NO>原始订单号</ORIGINAL_ORDER_NO>
# #         <ESHOP_ENT_CODE>海关10位编码</ESHOP_ENT_CODE>
# #         <ESHOP_ENT_NAME>公司名称</ESHOP_ENT_NAME>
# #         <DESP_ARRI_COUNTRY_CODE>起运国</DESP_ARRI_COUNTRY_CODE>
# #         <SHIP_TOOL_CODE>运输方式</SHIP_TOOL_CODE>
# #         <RECEIVER_ID_NO>收货人身份证号码</RECEIVER_ID_NO>
# #         <RECEIVER_NAME>收货人名字</RECEIVER_NAME>
# #         <RECEIVER_ADDRESS>收货人地址</RECEIVER_ADDRESS>
# #         <RECEIVER_TEL>收货人电话</RECEIVER_TEL>
# #         <GOODS_FEE>货款总额</GOODS_FEE>
# #         <TAX_FEE>税金总额</TAX_FEE>
# #         <GROSS_WEIGHT>毛重</GROSS_WEIGHT>
# #         <PROXY_ENT_CODE/>
# #         <PROXY_ENT_NAME/>
# #         <ORDER_DETAIL>
# #           <SKU>商品货号</SKU>
# #           <GOODS_SPEC>规格型号</GOODS_SPEC>
# #           <CURRENCY_CODE>币制代码</CURRENCY_CODE>
# #           <PRICE>商品单价</PRICE>
# #           <QTY>数量</QTY>
# #           <GOODS_FEE>商品总价</GOODS_FEE>
# #           <TAX_FEE>税款金额</TAX_FEE>
# #         </ORDER_DETAIL>
# #       </ORDER_HEAD>
# #     </DTCFlow>
# #   </MessageBody>
# # </DTC_Message>
