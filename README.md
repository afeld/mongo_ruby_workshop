# MongoDB + Ruby Workshop

## Contents

* [Slides](https://github.com/afeld/mongo_ruby_workshop/blob/complete/slides/README.md)
* [Exercise files](https://github.com/afeld/mongo_ruby_workshop/tree/complete/test) (disguised as tests)

## Get Started

Make sure that MongoDB 2.x is installed and running, and run:

```
bundle install
ruby mongo_wrapper.rb
mongo
```

If your database is properly started, you will now be in the MongoDB shell.  Now, within the shell, try the following commands to ensure the data is seeding properly:

```
> use mongo_ruby_demo;
switched to db mongo_ruby_demo
> db.users.count();
10
```

Great!  You can take a look through [`mongo_wrapper.rb`](https://github.com/afeld/mongo_ruby_workshop/blob/boilerplate/mongo_wrapper.rb) to get a sense of how the database is being populated.  Now, we want to work through our exercises in the [`tests/` directory](https://github.com/afeld/mongo_ruby_workshop/tree/boilerplate/test) - look for the `TODO`s.  Start up [Guard](https://github.com/guard/guard) to have them run automatically when you modify any Ruby files:

```
bundle exec guard
```

Now have at it!  You can also check out the [complete](https://github.com/afeld/mongo_ruby_workshop/tree/complete/test) versions, if you need a reference.

## Reference

* [CAP Theorem diagram](http://blog.beany.co.kr/wp-content/uploads/2011/03/nosql_cap.png)
* [MongoDB Manual](http://docs.mongodb.org/manual/)
* [Mongo gem rdoc](http://rubydoc.info/gems/mongo/1.8.4/frames)
* [Mongoid homepage](http://mongoid.org/)
* [Mongoid gem rdoc](http://rubydoc.info/gems/mongoid/3.1.2/frames)
