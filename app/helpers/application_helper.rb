module ApplicationHelper
    def full_title(page_title = '俳句で繋がる')
        base_title = "俳句で繋がる"
        if page_title.empty?
            base_title
        else
            page_title + " | " + base_title
        end
    end
end
