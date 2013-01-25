# coding: utf-8
ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #

    #     columns do
    #   column do
    #     panel "Statistics" do
    #       ul do
    #         Bill.last(3).map do |bill|
    #           li link_to(bill.price, admin_bill_path(bill))
    #         end
    #       end
    #     end
    #   end
    # end

    columns do
      column do
        panel "Statistics" do
          ul do
            li "Products in stock: #{Product.all.length}"
            li "2nd hand products in stock: #{SecondHandProduct.in_stock().length}"
            li "Total Billed last 30 days: #{Bill.last_30_days().map(&:price).inject(0){ |sum, i| sum + i }} €"
            li "Total Purchased last 30 days: #{Purchase.last_30_days().map(&:price).inject(0){ |sum, i| sum + i }} €"
            li "Total Billed last 7 days: #{Bill.last_7_days().map(&:price).inject(0){ |sum, i| sum + i }} €"
            li "Total Billed last 7 days: #{Purchase.last_7_days().map(&:price).inject(0){ |sum, i| sum + i }} €"
          end
        end

        panel "Owners with a second hand material sold" do
          ul do
            User.owners().with_material_sold().map do |user|
              li link_to user.full_name, admin_user_path(user)
            end
          end
        end
      end

    end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
