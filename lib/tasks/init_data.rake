namespace :init do

  desc "Init some user and project data"
  task :insert_data => :environment do
    ProductCatalog.delete_all
    Product.delete_all
    OrderStatus.delete_all
    Order.delete_all
    User.delete_all

    # add user and admin user

    User.create(:email => "admin@4ubest.com", :password => "start123",:password_confirmation =>"start123", :name => "管理员", :role => 2).save
    User.create(:email => "user@4ubest.com", :password => "start123", :password_confirmation =>"start123", :name => "辉哥", :role => 0).save
    user_id = User.find_by_email("user@4ubest.com").id

    # add product catalogs

    ProductCatalog.create(:name => "食品", :catalog_number => "012", :tax_rate => 0.1).save
    product_catalog_id = ProductCatalog.find_by_name("食品").id
    Product.create(:name => "爱他美Aptamil - 1段", :model => "900g", :unit => "罐", :customs_code => "4U000001", :product_catalog_id => product_catalog_id).save
    Product.create(:name => "爱他美Aptamil - 2段", :model => "900g", :unit => "罐", :customs_code => "4U000002", :product_catalog_id => product_catalog_id).save
    Product.create(:name => "爱他美Aptamil - 3段", :model => "900g", :unit => "罐", :customs_code => "4U000003", :product_catalog_id => product_catalog_id).save
    Product.create(:name => "爱他美Aptamil - 4段", :model => "800g", :unit => "罐", :customs_code => "4U000004", :product_catalog_id => product_catalog_id).save
    Product.create(:name => "牛栏 Cow&Gate - 1段", :model => "900g", :unit => "罐", :customs_code => "4U000005", :product_catalog_id => product_catalog_id).save
    Product.create(:name => "牛栏 Cow&Gate - 2段", :model => "900g", :unit => "罐", :customs_code => "4U000006", :product_catalog_id => product_catalog_id).save
    Product.create(:name => "牛栏 Cow&Gate - 3段", :model => "900g", :unit => "罐", :customs_code => "4U000007", :product_catalog_id => product_catalog_id).save
    Product.create(:name => "牛栏 Cow&Gate - 4段", :model => "800g", :unit => "罐", :customs_code => "4U000008", :product_catalog_id => product_catalog_id).save

    ["未提交", "已提交平台", "平台审核通过", "平台审核未通过", "已推送海关", "海关审核通过", "海关审核未通过", "已推送物流", "结关"].each do |status|
      OrderStatus.create(:status => status).save
    end



    Order.create(
      :order_status_id => OrderStatus.find_by_status("未提交").id,
      :origin_order_number => "2017102654811",
      :origin_payment_number => "201710260000100014305762180",
      :customer_name => "李翠娴",
      :phone => "15361448901",
      :id_number => "441424198111294241",
      :province => "广东省",
      :city => "深圳市",
      :area => "宝安区",
      :street => "岩镇浪心村2路14电",
      :zip_code => "518100",
      :user_id => user_id,
      :shipping_fee => 10
    ).save

    order_id = Order.last.id

    OrderProduct.create(
      :order_id => order_id,
      :product_id => Product.find_by_name("爱他美Aptamil - 1段"),
      :custom_price => 180,
      :number => 2
    ).save


    Order.create(
      :order_status_id => OrderStatus.find_by_status("已提交平台").id,
      :origin_order_number => "2016102654811",
      :origin_payment_number => "201610260000100014305762180",
      :customer_name => "李翠娴",
      :phone => "15361448901",
      :id_number => "441424198911294241",
      :province => "广东省",
      :city => "深圳市",
      :area => "宝安区",
      :street => "岩镇浪心村2路14电",
      :zip_code => "518100",
      :user_id => user_id,
      :shipping_fee => 10
    ).save

    order_id = Order.last.id

    OrderProduct.create(
      :order_id => order_id,
      :product_id => Product.find_by_name("爱他美Aptamil - 1段"),
      :custom_price => 180,
      :number => 1
    ).save

    OrderProduct.create(
      :order_id => order_id,
      :product_id => Product.find_by_name("爱他美Aptamil - 2段"),
      :custom_price => 200,
      :number => 1
    ).save



    Order.create(
      :order_status_id => OrderStatus.find_by_status("平台审核通过").id,
      :origin_order_number => "2015102654811",
      :origin_payment_number => "201510260000100014305762180",
      :customer_name => "张翠娴",
      :phone => "15361448901",
      :id_number => "441424197911294241",
      :province => "广东省",
      :city => "深圳市",
      :area => "宝安区",
      :street => "岩镇浪心村2路14电",
      :zip_code => "518100",
      :user_id => user_id,
      :shipping_fee => 10
    ).save

    order_id = Order.last.id

    OrderProduct.create(
      :order_id => order_id,
      :product_id => Product.find_by_name("爱他美Aptamil - 1段"),
      :custom_price => 180,
      :number => 1
    ).save

    OrderProduct.create(
      :order_id => order_id,
      :product_id => Product.find_by_name("牛栏 Cow&Gate - 1段"),
      :custom_price => 200,
      :number => 1
    ).save


    Order.create(
      :order_status_id => OrderStatus.find_by_status("平台审核未通过").id,
      :origin_order_number => "2014102654811",
      :origin_payment_number => "201410260000100014305762180",
      :customer_name => "黄翠娴",
      :phone => "15361448901",
      :id_number => "441424196911294241",
      :province => "广东省",
      :city => "深圳市",
      :area => "宝安区",
      :street => "岩镇浪心村2路14电",
      :zip_code => "518100",
      :user_id => user_id,
      :shipping_fee => 10
    ).save

    order_id = Order.last.id

    OrderProduct.create(
      :order_id => order_id,
      :product_id => Product.find_by_name("爱他美Aptamil - 1段"),
      :custom_price => 180,
      :number => 3
    ).save

    Order.create(
      :order_status_id => OrderStatus.find_by_status("已推送海关").id,
      :origin_order_number => "2013102654811",
      :origin_payment_number => "201310260000100014305762180",
      :customer_name => "李翠娴",
      :phone => "15361448901",
      :id_number => "441424198911294241",
      :province => "广东省",
      :city => "深圳市",
      :area => "宝安区",
      :street => "岩镇浪心村2路14电",
      :zip_code => "518100",
      :user_id => user_id,
      :shipping_fee => 10
    ).save

        order_id = Order.last.id

    OrderProduct.create(
      :order_id => order_id,
      :product_id => Product.find_by_name("爱他美Aptamil - 1段"),
      :custom_price => 180,
      :number => 1
    ).save

    OrderProduct.create(
      :order_id => order_id,
      :product_id => Product.find_by_name("牛栏 Cow&Gate - 1段"),
      :custom_price => 180,
      :number => 1
    ).save

    OrderProduct.create(
      :order_id => order_id,
      :product_id => Product.find_by_name("牛栏 Cow&Gate - 4段"),
      :custom_price => 180,
      :number => 1
    ).save
  end
end
