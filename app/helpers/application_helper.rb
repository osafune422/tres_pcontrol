module ApplicationHelper
    def show_time(time)
        time.strftime("%H:%M")
    end
    
    def show_date(time)
        time.strftime("%Y年%m月%d日")
    end
end
