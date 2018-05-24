module ApplicationHelper
    def show_time(time)
        time.strftime("%H:%M")
    end
    
    def show_date(time)
        time.strftime("%m-%d")
    end
end
