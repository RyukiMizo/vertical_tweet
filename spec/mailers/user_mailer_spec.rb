require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  #let(:user) {FactoryBot.create(:user)}
  #describe "アカウントの有効化" do
    #let(:mail) { UserMailer.account_activation(user) }

    #it "タイトル、メールが正しい" do
      #expect(mail.subject).to eq("アカウントの確認")
      #expect(mail.to).to eq(["aa1@aa.aa"])
      #expect(mail.from).to eq(["noreply@gmail.com"])
    #end

    #it "内容に正しい情報が含まれている" do
      #expect(mail.body.encoded).to match user.name
      #expect(mail.body.encoded).to match "こんにちは"
      #expect(mail.body.encoded).to match CGI.escape(user.email)
    #end
  #end
end
