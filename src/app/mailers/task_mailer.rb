class TaskMailer < ApplicationMailer
  default from: 'genva@example.com'

  def creation_email(task)
    @task = task
    mail(
      subject: 'タスク作成完了メール',
      to: 'user@example.com',
      from: 'genva@example.com'
    )
  end
end
