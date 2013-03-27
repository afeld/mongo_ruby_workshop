# MongoDB on Ruby

Aidan Feldman

Sẽnor Web Developer, [Jux](https://jux.com)

-------------

Download/clone/fork @

[github.com/afeld/mongo_ruby_workshop](https://github.com/afeld/mongo_ruby_workshop)

!SLIDE

## I ain't hatin'.

!SLIDE

# Your Schema on SQL

    @@@sql
    CREATE TABLE table_name (
      column_name1 data_type,
      column_name2 data_type,
      column_name3 data_type,
      ....
    );

!SLIDE

# Your Schema on NoSQL

    @@@javascript
    //
    //
    //
    //
    //
    //
    //
    //

!SLIDE

# Flexible Schema

* Embedded lists
* Embedded documents
* Simple STI

!SLIDE

# Schema considerations

* Joins can't be done at the DB level
* It's ok to denormalize
* Preferable to have docs of similar size

!SLIDE

# Awesome things

* *FAST*
* Atomic operations
* No injection worries
