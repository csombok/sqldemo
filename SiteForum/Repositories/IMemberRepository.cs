using System.Collections.Generic;
using SiteForum.Exceptions;
using SiteForum.Model;

namespace SiteForum.Repositories
{
    /// <summary>
    /// Repository interface for <see cref="Member"/> objects.
    /// </summary>
    public interface IMemberRepository
    {
        /// <summary>
        /// Get all members.
        /// </summary>
        /// <returns>Member objects.</returns>
        IEnumerable<Member> GetMembers();

        /// <summary>
        /// Add a new member.
        /// </summary>
        /// <param name="member">The member.</param>
        /// <returns>Id of the new member object.</returns>
        int AddMember(Member member);

        /// <summary>
        /// Update a member object.
        /// </summary>
        /// <param name="member">The member.</param>
        /// <exception cref="MemberNotFoundException">
        /// Throw when repository doesn't contain any member with the supplied id.
        /// </exception>
        void UpdateMember(Member member);

        /// <summary>
        /// Delete a member by id.
        /// </summary>
        /// <param name="memberId">Id of the member.</param>
        /// <exception cref="MemberNotFoundException">
        /// Throw when repository doesn't contain any member with the supplied id.
        /// </exception>
        /// <remarks>Implement as a cascade delete for root objects. Delete all associated posts and comments added by the member.</remarks>        
        void DeleteMember(int memberId);        
    }
}
