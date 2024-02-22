//
//  Repository.swift
//  PeraWalletAssignment
//
//  Created by Tayfun Sagdic on 19.02.2024.
//

import Foundation

struct Repository: Codable, Identifiable {
    let id: Int
    let node_id: String
    let name: String
    let full_name: String
    let owner: Owner
    let html_url: URL
    let description: String?
    let fork: Bool
    let url: URL
    let archive_url: String
    let assignees_url: String
    let blobs_url: String
    let branches_url: String
    let collaborators_url: String
    let comments_url: String
    let commits_url: String
    let compare_url: String
    let contents_url: String
    let contributors_url: String
    let deployments_url: String
    let downloads_url: String
    let events_url: String
    let forks_url: String
    let git_commits_url: String
    let git_refs_url: String
    let git_tags_url: String
    let git_url: String
    let issue_comment_url: String
    let issue_events_url: String
    let issues_url: String
    let keys_url: String
    let labels_url: String
    let languages_url: String
    let merges_url: String
    let milestones_url: String
    let notifications_url: String
    let pulls_url: String
    let releases_url: String
    let ssh_url: String
    let stargazers_url: String
    let statuses_url: String
    let subscribers_url: String
    let subscription_url: String
    let tags_url: String
    let teams_url: String
    let trees_url: String
    let clone_url: String
}

struct Owner: Codable {
    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let gravatar_id: String
    let url: String
    let html_url: URL
    let followers_url: String
    let following_url: String
    let gists_url: String
    let starred_url: String
    let subscriptions_url: String
    let organizations_url: String
    let repos_url: String
    let events_url: String
    let received_events_url: String
    let type: String
    let site_admin: Bool
}
