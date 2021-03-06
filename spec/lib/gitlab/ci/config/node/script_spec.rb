require 'spec_helper'

describe Gitlab::Ci::Config::Node::Script do
  let(:entry) { described_class.new(config) }

  describe '#process!' do
    before { entry.process! }

    context 'when entry config value is correct' do
      let(:config) { ['ls', 'pwd'] }

      describe '#value' do
        it 'returns concatenated command' do
          expect(entry.value).to eq "ls\npwd"
        end
      end

      describe '#errors' do
        it 'does not append errors' do
          expect(entry.errors).to be_empty
        end
      end

      describe '#valid?' do
        it 'is valid' do
          expect(entry).to be_valid
        end
      end
    end

    context 'when entry value is not correct' do
      let(:config) { 'ls' }

      describe '#errors' do
        it 'saves errors' do
          expect(entry.errors)
            .to include 'Script config should be an array of strings'
        end
      end

      describe '#valid?' do
        it 'is not valid' do
          expect(entry).not_to be_valid
        end
      end
    end
  end
end
