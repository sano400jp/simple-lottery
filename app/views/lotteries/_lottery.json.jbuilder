json.extract! lottery, :id, :code, :owner_code, :title, :draw_time, :redraw_range, :nonres_redraw, :end_time, :created_at, :updated_at
json.url lottery_url(lottery, format: :json)
