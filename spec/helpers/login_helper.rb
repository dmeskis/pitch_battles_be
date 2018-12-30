module LoginHelper
  def create_student
    student = User.new(
                      email: 'test@mail.com',
                      password: 'password',
                      password_confirmation: 'password',
                      first_name: 'Bob',
                      last_name: 'Ross',
                      role: "student"
                      )

    student.save
  end

  def create_teacher
    teacher = User.new(
                    email: 'test@mail.com',
                    password: 'password',
                    password_confirmation: 'password',
                    first_name: 'Bob',
                    last_name: 'Ross',
                    role: "teacher"
                    )

    teacher.save
  end

  def login
    body = {
            email: 'test@mail.com',
            password: 'password'
           }

    post '/login', :params => body
  end
end