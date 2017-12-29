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

class TestCase5
  def hoge_1
    piyo_2
    fuga_3
  end

  def piyo_2
  end

  def fuga_3
    foo_4
  end

  def foo_4
  end
end

class TestCase6
  def dfs(str = 'a')
    return if str > 'd'
    dfs(str.next)
  end
end
