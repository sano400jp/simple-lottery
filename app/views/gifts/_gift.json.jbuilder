json.extract! gift, :id, :lottery_code, :name, :start_cnt, :delived_cnt, :image_l_url, :image_m_url, :image_s_url, :created_at, :updated_at
json.url gift_url(gift, format: :json)
