class TestCase1
  def hoge
    piyo
    fuga
  end

  def piyo
  end

  def fuga
    foo
  end

  def foo
  end
end

class TestCase2 < TestCase1
  def hoge
    piyo
    fuga
  end

  def foo
  end
end

class TestCase3
  def self.hoge
    new.piyo
  end

  def piyo
    foo
  end

  def foo
  end
end

class TestCase4
  def hoge
    piyo
    fuga
    fuga
  end

  def piyo
  end

  def fuga
    foo
  end

  def foo
  end
end
