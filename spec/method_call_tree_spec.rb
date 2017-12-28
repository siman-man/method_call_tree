require 'fixtures/example'

RSpec.describe MethodCallTree do
  it 'test case 1' do
    tree = MethodCallTree.create { TestCase1.new.hoge }

    expect = <<-EXPECT
TestCase1::hoge
├───── TestCase1::piyo
└───── TestCase1::fuga
        └───── TestCase1::foo
    EXPECT

    expect(tree.to_s).to eq(expect)
  end

  it 'test case 2' do
    tree = MethodCallTree.create { TestCase2.new.hoge }

    expect = <<-EXPECT
TestCase2::hoge
├───── TestCase1::piyo
└───── TestCase1::fuga
        └───── TestCase2::foo
    EXPECT

    expect(tree.to_s).to eq(expect)
  end

  it 'test case 3' do
    tree = MethodCallTree.create { TestCase3.hoge }

    expect = <<-EXPECT
#<Class:TestCase3>::hoge
└───── TestCase3::piyo
        └───── TestCase3::foo
    EXPECT

    expect(tree.to_s).to eq(expect)
  end
end
