require 'rails_helper'

describe 'タスク管理機能', type: :system do
  # ユーザーAを作成しておく
  let(:user_a) { FactoryBot.create(:admin_user, name: 'ユーザーA', email: 'a@example.com') }
  # ユーザーBを作成しておく
  let(:user_b) { FactoryBot.create(:admin_user, name: 'ユーザーB', email: 'b@example.com') }
  # 作成者がユーザーAであるタスクを作成しておく
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

  before do
    # ログインする
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード',	with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初のタスク' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }
      it 'ユーザーAが作成したタスクが表示されない' do
        # ユーザーAが作成したタスクが画面上に表示されないことを確認
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }
    let(:task_name) { '新規作成のテストを書く' }
    before do
      visit new_task_path
      fill_in '名称',	with: task_name
      click_button '確認'
    end

    context '新規作成画面で名称を入力した時' do
      it '正常に登録される' do
        click_button '登録'
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかった時' do
      let(:task_name) { '' }
      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '名称 を入力してください'
        end
      end
    end
  end
end
