//
//  FindNavigatorView.swift
//  CodeEdit
//
//  Created by Ziyuan Zhao on 2022/3/20.
//

import SwiftUI

struct FindNavigatorView: View {
    @EnvironmentObject private var workspace: WorkspaceDocument

    private var state: WorkspaceDocument.SearchState {
        workspace.searchState ?? .init(workspace)
    }

    @State var currentFilter: String = ""
    @State private var foundFilesCount: Int = 0
    @State private var searchResultCount: Int = 0

    enum Filters: String {
        case ignoring = "Ignoring Case"
        case matching = "Matching Case"
    }

    var body: some View {
        VStack {
            FindNavigatorForm(state: state)
            Divider()
            HStack(alignment: .center) {
                Text("\(self.searchResultCount) results in \(self.foundFilesCount) files")
                    .font(.system(size: 10))
            }
            Divider()
            FindNavigatorResultList()
        }
        .onReceive(state.objectWillChange) { _ in
            self.searchResultCount = state.searchResultCount
            self.foundFilesCount = state.searchResult.count
        }
    }
}
