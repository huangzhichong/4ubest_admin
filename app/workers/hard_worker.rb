class HardWorker
  include Sidekiq::Worker

  #post order and order payment info
  def perform(order_id)
    # do something
    puts get_order_xml(Order.find(order_id))
  end

  def get_payment_xml
    order_template = File.open("#{File.dirname(__FILE__)}/payment_template.xml")
    payment_xml = REXML::Document.new order_template
    payment_xml.get_elements("//MessageHead/MessageId")[0].text = UUID.new.generate
    payment_xml.get_elements("//MessageHead/MessageTime")[0].text = Time.now
    payment_xml.get_elements("//MessageHead/SenderId")[0].text = ENV['CUSTOM_CODE']
    payment_xml.get_elements("//MessageHead/UserNo")[0].text = ENV['CUSTOM_CODE']
    payment_xml.get_elements("//MessageHead/Password")[0].text = ENV['CQITC_PASSWORD']

    payment_xml.get_elements("//PAYMENT_INFO/CUSTOMS_CODE")[0].text = "关区代码"
    payment_xml.get_elements("//PAYMENT_INFO/BIZ_TYPE_CODE")[0].text = "直购，网购代码"
    payment_xml.get_elements("//PAYMENT_INFO/ESHOP_ENT_CODE")[0].text = ENV['CUSTOM_CODE']
    payment_xml.get_elements("//PAYMENT_INFO/ESHOP_ENT_NAME")[0].text = "公司名称"

    payment_xml.get_elements("//PAYMENT_INFO/PAYMENT_ENT_CODE")[0].text = "海关10位编码"
    payment_xml.get_elements("//PAYMENT_INFO/PAYMENT_ENT_NAME")[0].text = "企业名称"
    payment_xml.get_elements("//PAYMENT_INFO/PAYMENT_NO")[0].text = order.origin_payment_number
    payment_xml.get_elements("//PAYMENT_INFO/ORIGINAL_ORDER_NO")[0].text = order.origin_order_number
    payment_xml.get_elements("//PAYMENT_INFO/PAY_AMOUNT")[0].text = (order.total_price + order.total_tax_fee)
    payment_xml.get_elements("//PAYMENT_INFO/GOODS_FEE")[0].text = order.total_price
    payment_xml.get_elements("//PAYMENT_INFO/TAX_FEE")[0].text = order.total_tax_fee
    payment_xml.get_elements("//PAYMENT_INFO/CURRENCY_CODE")[0].text = "支付币制"

    payment_xml
  end



  def get_order_xml(order)
    order_template = File.open("#{File.dirname(__FILE__)}/order_template.xml")
    order_xml = REXML::Document.new order_template
    order_xml.get_elements("//MessageHead/MessageId")[0].text = UUID.new.generate
    order_xml.get_elements("//MessageHead/MessageTime")[0].text = Time.now
    order_xml.get_elements("//MessageHead/SenderId")[0].text = ENV['CUSTOM_CODE']
    order_xml.get_elements("//MessageHead/UserNo")[0].text = ENV['CUSTOM_CODE']
    order_xml.get_elements("//MessageHead/Password")[0].text = ENV['CQITC_PASSWORD']
    order_xml.get_elements("//ORDER_HEAD/ORIGINAL_ORDER_NO")[0].text = order.origin_order_number
    order_xml.get_elements("//ORDER_HEAD/ESHOP_ENT_CODE")[0].text = ENV['CUSTOM_CODE']
    order_xml.get_elements("//ORDER_HEAD/ESHOP_ENT_NAME")[0].text = "公司名称"
    order_xml.get_elements("//ORDER_HEAD/DESP_ARRI_COUNTRY_CODE")[0].text = "起运国"
    order_xml.get_elements("//ORDER_HEAD/SHIP_TOOL_CODE")[0].text = "运输方式"
    order_xml.get_elements("//ORDER_HEAD/RECEIVER_ID_NO")[0].text = order.id_number
    order_xml.get_elements("//ORDER_HEAD/RECEIVER_NAME")[0].text = order.customer_name
    order_xml.get_elements("//ORDER_HEAD/RECEIVER_ADDRESS")[0].text = order.shipping_address
    order_xml.get_elements("//ORDER_HEAD/RECEIVER_TEL")[0].text = order.phone
    order_xml.get_elements("//ORDER_HEAD/GOODS_FEE")[0].text = order.total_price
    order_xml.get_elements("//ORDER_HEAD/TAX_FEE")[0].text = order.total_tax_fee
    order_xml.get_elements("//ORDER_HEAD/GROSS_WEIGHT")[0].text = order.total_weight

    order.order_products.each do |order_product|
      order_detail = order_xml.get_elements("//ORDER_HEAD")[0].add_element("ORDER_DETAIL")
      sku = order_detail.add_element("SKU")
      sku.add_text order_product.product.customs_code

      goods_spec = order_detail.add_element("GOODS_SPEC")
      goods_spec.add_text order_product.product.name

      currency_code = order_detail.add_element("CURRENCY_CODE")
      currency_code.add_text "币制代码"

      price = order_detail.add_element("PRICE")
      price.add_text order_product.custom_price.to_s

      number = order_detail.add_element("QTY")
      number.add_text order_product.number.to_s

      total_price = order_detail.add_element("GOODS_FEE")
      total_price.add_text order_product.item_total_price.to_s

      total_tax_fee = order_detail.add_element("TAX_FEE")
      total_tax_fee.add_text order_product.item_total_tax_fee.to_s
    end

    order_xml
  end

end
