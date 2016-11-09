using System;

namespace SiteForum.Exceptions
{
    public class MemberNotFoundException : Exception
    {
        public MemberNotFoundException(string message)
            : base(message)
        { }
    }
}