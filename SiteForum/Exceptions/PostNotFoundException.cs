using System;

namespace SiteForum.Exceptions
{
    public class PostNotFoundException : Exception
    {
        public PostNotFoundException(string message)
            : base(message)
        { }
    }

    public class MemberNotFoundException : Exception
    {
        public MemberNotFoundException(string message)
            : base(message)
        { }
    }
}