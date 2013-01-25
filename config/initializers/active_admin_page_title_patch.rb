# module ActiveAdmin
#   module Views
#     module Pages
#       class Index < Base
#         def title
#           if config[:page_title].blank?
#             active_admin_config.plural_resource_name
#           else
#             config[:page_title]
#           end
#         end
#       end
#     end
#   end
# end