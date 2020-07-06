require "spec_helper"

describe "crowdfunder sql" do
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
  end

  describe "create.sql" do
    before do
      @sql_runner.execute_create_sql
    end

    it "creates a projects table with an id as a primary key" do
      expect(@db.execute("PRAGMA table_info(projects);").detect { |arr| arr[-1] == 1 && arr[2] == "INTEGER" }.length).to eq(6)
    end

    it "creates a projects table with a title field" do
      expect{@db.execute("SELECT title FROM projects;")}.to_not raise_exception
    end

    it "creates a projects table with a category field" do
      expect{@db.execute("SELECT category FROM projects;")}.to_not raise_exception
    end

    it "creates a projects table with a funding_goal field" do
      expect{@db.execute("SELECT funding_goal FROM projects;")}.to_not raise_exception
    end

    it "creates a projects table with a start_date field" do
      expect{@db.execute("SELECT start_date FROM projects;")}.to_not raise_exception
    end

    it "creates a projects table with a end_date field" do
      expect{@db.execute("SELECT end_date FROM projects;")}.to_not raise_exception
    end

    it "creates a users table with an id as a primary key" do
      expect(@db.execute("PRAGMA table_info(users);").detect { |arr| arr[-1] == 1 && arr[2] == "INTEGER" }.length).to eq(6)
    end

    it "creates a users table with a name field" do
      expect{@db.execute("SELECT name FROM users;")}.to_not raise_exception
    end

    it "creates a users table with an age field" do
      expect{@db.execute("SELECT age FROM users;")}.to_not raise_exception
    end

    it "creates a pledges table with an id as a primary key" do
      expect(@db.execute("PRAGMA table_info(pledges);").detect { |arr| arr[-1] == 1 && arr[2] == "INTEGER" }.length).to eq(6)
    end

    it "creates a pledges table with an amount field" do
      expect{@db.execute("SELECT amount FROM pledges;")}.to_not raise_exception
    end

    it "creates a pledges table with a user_id field" do
      expect{@db.execute("SELECT user_id FROM pledges;")}.to_not raise_exception
    end

    it "creates a pledges table with a project_id field" do
      expect{@db.execute("SELECT project_id FROM pledges;")}.to_not raise_exception
    end

  end

  describe "insert.sql" do
    before do
      @sql_runner.execute_create_sql
      @sql_runner.execute_insert_sql
    end

    it "has 20 users" do
      expect(@db.execute("SELECT COUNT(*) FROM users;").flatten[0]).to eq(20)
    end

    it "has 10 projects" do
      expect(@db.execute("SELECT COUNT(*) FROM projects;").flatten[0]).to eq(10)
    end

    it "has 30 pledges" do
      expect(@db.execute("SELECT COUNT(*) FROM pledges;").flatten[0]).to eq(30)
    end

  end

  describe "questions" do
    before do
      @sql_runner.execute_create_sql
      @sql_runner.execute_data
    end
    after do
      File.read('lib/data.sql')
    end

    
  end
end
