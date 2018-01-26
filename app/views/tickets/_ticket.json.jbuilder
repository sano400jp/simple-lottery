json.extract! ticket, :id, :lottery_code, :seq, :token, :gift_seq, :act_flg, :status, :created_at, :updated_at, guest_code
json.url ticket_url(ticket, format: :json)
