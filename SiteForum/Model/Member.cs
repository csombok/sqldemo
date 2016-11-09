using System.Collections.Generic;

namespace SiteForum.Model
{
    public class Member
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public ContactInfo Contact { get; set; }
        public IEnumerable<Post> Posts { get; set; }
    }
}
