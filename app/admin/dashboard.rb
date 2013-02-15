# coding: utf-8
ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "School" do
          if Contract.active.length >0
            panel "Active contracts" do
              table_for Contract.active() do
                column "Student" do |c|
                  link_to c.user.full_name, admin_user_path(c.user)
                end
                column "Hours left" do |c|
                  "#{c.hours_left()} h."
                end
                column "Contract" do |c|
                  link_to "View Contract", admin_contract_path(c)
                end
              end
            end
          else
            h4 "0 active contracts"
          end
          if Contract.waiting_for_payment().length >0
            panel "Contracts waiting for payments" do
              table_for Contract.waiting_for_payment() do
                column "Student" do |c|
                  link_to c.user.full_name, admin_user_path(c.user)
                end
                column "need to pay" do |c|
                  "#{c.need_to_pay()} €"
                end
                column "Contract" do |c|
                  link_to "View Contract", admin_contract_path(c)
                end
              end
            end
          else
            h4 "0 contract waiting for payments"
          end
          if Rental.active().length > 0
            panel "Rented equipment" do
              table_for Rental.active() do
                column "Client" do |r|
                  link_to r.user.full_name, admin_user_path(r.user)
                end
                column :materials do |rent|
                  rent.borrows.map { |b| "#{b.quantity} #{b.material.name}" }.join("<br />").html_safe
                end
                column :start_time
                column :end_time
                column "Rental" do |r|
                  link_to "View Rental", admin_rental_path(r)
                end
              end
            end
            else
              h4 "0 equipment rented"
          end
        end
        panel "Shop" do
          if Product.out_of_stock().length > 0
            panel "Out Of Stock" do
              table_for Product.out_of_stock() do
                column :name
                column :brand
                column :distributor
                column :color
                column :size
                column :year
              end
            end
          else
              h4 "0 product out of stock"
          end
          if User.second_hand_product_owners().with_material_sold().uniq().length > 0
            panel "Second Hand Product owner with equipment sold" do
              table_for User.second_hand_product_owners().with_material_sold().uniq() do
                column "Owner" do |user|
                  link_to user.full_name, admin_user_path(user)
                end
              end
            end
          else
              h4 "0 second hand product owner with equipment sold"
          end
        end
        panel "Accounting" do
          ul do
            li "#{Bill.last_30_days().map(&:price).inject(0){ |sum, i| sum + i }} € earned last 30 days."
            li "#{Purchase.last_30_days().map(&:price).inject(0){ |sum, i| sum + i }} € spent last 30 days."
            li "#{Bill.last_7_days().map(&:price).inject(0){ |sum, i| sum + i }} € earned last 7 days."
            li "#{Purchase.last_7_days().map(&:price).inject(0){ |sum, i| sum + i }} € spent last 7 days"
          end
        end
      end
    end
  end # content
end
