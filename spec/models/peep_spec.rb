require './app/data_mapper_setup'

describe Peep do 
	it "will have a timestamp on creation" do
    #I could also have utilised the TimeCop gem.
		peep = Peep.create(content: 'Testing 123', time: Time.now)
		expect(peep.time.to_s).to eq Time.now.to_s
	end

  context "Checking that datamapper works" do
    let(:user) { FactoryGirl.create(:user) }
    subject { Peep.new(content: 'My first peep!', user: user, time: Time.now) }
    
    it "can be created and then retrieved from the db" do
      expect(Peep.count).to eq(0)
      subject.save
      expect(Peep.count).to eq(1)
      expect(subject.content).to eq('My first peep!')
      subject.destroy
      expect(Peep.count).to eq(0)
    end
  end
end

