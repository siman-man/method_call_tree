require 'fixtures/example'

RSpec.describe MethodCallTree do
  it 'test case 1' do
    tree = MethodCallTree.create(class: true) { TestCase1.new.hoge }

    expect = <<-EXPECT
TestCase1::hoge
├───── TestCase1::piyo
└───── TestCase1::fuga
        └───── TestCase1::foo
    EXPECT

    expect(tree.to_s).to eq(expect)
  end

  it 'test case 2' do
    tree = MethodCallTree.create(class: true) { TestCase2.new.hoge }

    expect = <<-EXPECT
TestCase2::hoge
├───── TestCase1::piyo
└───── TestCase1::fuga
        └───── TestCase2::foo
    EXPECT

    expect(tree.to_s).to eq(expect)
  end

  it 'test case 3' do
    tree = MethodCallTree.create(class: true) { TestCase3.hoge }

    expect = <<-EXPECT
#<Class:TestCase3>::hoge
└───── TestCase3::piyo
        └───── TestCase3::foo
    EXPECT

    expect(tree.to_s).to eq(expect)
  end

  it 'test case 4' do
    tree = MethodCallTree.create(class: true) { TestCase4.new.hoge }

    expect = <<-EXPECT
TestCase4::hoge
├───── TestCase4::piyo
├───── TestCase4::fuga
│       └───── TestCase4::foo
└───── TestCase4::fuga
        └───── TestCase4::foo
    EXPECT

    expect(tree.to_s).to eq(expect)
  end

  it 'test case 5' do
    tree = MethodCallTree.create(class: true) { TestCase5.new.hoge_1 }

    expect = <<-EXPECT
TestCase5::hoge_1
├───── TestCase5::piyo_2
└───── TestCase5::fuga_3
        └───── TestCase5::foo_4
    EXPECT

    expect(tree.to_s).to eq(expect)
  end

  it 'test case 6' do
    tree = MethodCallTree.create(class: true, args: true) { TestCase6.new.dfs }

    expect = <<-EXPECT
TestCase6::dfs(str = "a")
└───── TestCase6::dfs(str = "b")
        └───── TestCase6::dfs(str = "c")
                └───── TestCase6::dfs(str = "d")
                        └───── TestCase6::dfs(str = "e")
    EXPECT

    expect(tree.to_s).to eq(expect)
  end
end
