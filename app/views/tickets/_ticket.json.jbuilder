json.extract! ticket, :id, :lottery_code, :seq, :token, :gift_seq, :act_flg, :status, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
